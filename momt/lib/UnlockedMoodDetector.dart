/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:momt/UI/pages/kidsDashoard.dart';
import 'package:momt/enums/Mood.dart';
import 'package:momt/services/request.dart';

import 'UI/pages/MusicPlayer.dart';

class UnlockedMoodScreen extends StatefulWidget {
  final XFile image;

  UnlockedMoodScreen({required this.image});

  @override
  _UnlockedMoodScreenState createState() => _UnlockedMoodScreenState();
}

class _UnlockedMoodScreenState extends State<UnlockedMoodScreen> {
  Mood _expression = Mood.SORROW;
  String stressedMsg = "Stressed out. Play music to refresh";
  String haapyMsg = "Let's start with your smile";

  void navigateToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => KidsDashboard()));
  }

  void getExpression() => {
        getBytesFromFile().then((bytes) async {
          Map<String, String> header = {
            HttpHeaders.authorizationHeader: 'Bearer ' + await getAuthToken()
          };

          var response = await Request.post(
              'https://vision.googleapis.com/v1/images:annotate', header, {
            "requests": [
              {
                "image": {
                  "content": base64.encoder.convert(bytes.buffer.asUint8List())
                },
                "features": [
                  {"maxResults": 10, "type": "FACE_DETECTION"}
                ]
              }
            ]
          });
          print(response.runtimeType);
          print('respMsg $response');
          setState(() {
            _expression = parseEmotionsResponse(response);
          });

          // Share the map to some db or service from here
        })
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MomT"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            new Container(
              height: 400,
              child: Image.asset("assets/images/moodDetector.png"),
            ),
            new Text(
              'Hello Vishva !',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            new Text(
              _expression == Mood.JOY ? haapyMsg : stressedMsg,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            new MusicPlayer()
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getExpression();
          navigateToProfile(context);
        },
        tooltip: 'Next',
        //label: const Text('Skip'),
        child: Icon(
          Icons.arrow_forward,
          size: 40,
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.image.path).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }

  Future<String> getAuthToken() async {
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "quixotic-booth-281410",
      "private_key_id": "e886339bdc62a067ce163d359242a6530885beaa",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQChdntHsa0c5AcI\nE7fc/XxAZx4qP2ZGZHYMaLScr9dM9bM0IdsKSQzTEMmoBPSQ9uYSZiGOTCjlQiT9\nIf2K/iVEkx6E15+GtIAm/s09oTAWeSsjz87HpzW0+pw8q7Tl6EW8p1UIJfOK9Wbi\n5vbMDImzDkwbHYWYvyXBFjf4mvk5PoF/0rkTWraQfnaYcf2ZkEK/oQoPDjP9rpRz\n7XWDwV21sPxcKynENdaOWd87sVH+O8S+3AaP1M5f/RkV/0BYVaN/hA9I7UDqbGnj\nU1L4VMIyqRRQoq83RQs33bmXt5gmxdRpjLTSXz43/n4Pl2CwzlsRDErSKYlLBAP+\nvPg6NSchAgMBAAECggEABFTRZSylcUHGdMNzJmfsIy3k+bMIUUV5A3eUV0LyEI3j\nhhetqKCpqfiQgUvrO9+Mr9QKrMabHv3LkFkO5DFxwl18N0nxvQdG7AzgKHnkSGkN\nFMWKhXF1S87gfbHpPRTiWIeIXNroResz/KyflJ0WPU36EYzk4GJpzsyD2TzeiEgb\nn/abuSBLngA6XTCGnXgaeNvW3dWfd559JL5jE0kKOEzQBluSgdwSXMsm74tmvNMa\nZQ3fHw60tbMNoRZRAb0zKOKYn+l9jt2KBH2o4Q4eF44FIZyt3gQkU8K+Z8ZvdYD8\npMj8ucIXgqD6aqzRVKs5xwImwQfbWzuaODIxdpz5AQKBgQDP9BTri+z5mIK8MiY6\n9zNuK8VqQEdBEvYvoc60/18nKBByWDpv6HXeugj+PumJn7xTRUIqLhrMvAh1n0OG\nEKlG/wBmdB74SyUu/14f457cckYdhvGyAWFXe6yWjPsTudi7H5pZq5x0fq2j0XgM\n0h4kEMP4UNW8vYnxj7aB9vrygQKBgQDGxJjtEOU+UD1GQ/u4AUyKBz1YMcv5Y4hL\nKKEMjr3udfW/0pS555shr5nFbbEphmkPN3inQHOSYuQlMf4o68Ty1kMrPL1ljoux\n9m8nF0uyDSVL3L++pksvKr+wFdqGfbv++ZECzzM8glITEueCwoNDm7NIn1N4OoTP\nFr/2DwikoQKBgFF3I0LrfBiDoKOtWcC72tAMIbhwGfnqPbuHPf02Fca3MUo6Ohph\nDNwGMUO4zbB2fUZ52WPA0Arolr/NdpxspoQDndqFHyTR+20f6XXArBlcQw+KL+E2\nHTYyYvhPnoSpx7f2t3btfcs9XTTR+J+9KMWkM8FxmWnpLsMNM8hSQxkBAoGAStGj\n8tCCSiNv/SwH62ppwicZe0I7UmOZ4RipDo4IhmNWnt8IZrX8mgB8dGlm34edskGi\nI+rJ1hdtY2bfEc41s2bdn7/cVwcCJHnrux40uw/hsx2j+4KjGF0SDJkdSbS4eDC+\n2fzef29ar51VEc5gFKneIX7/r2jvpvgcR+W+ziECgYEAtOoK+1usa8xza7hAD79m\nmYCFGQqSC9lT12uxLmCbVtc1o6XLBqyBqHGqVMxKAs62PpBWk3yDhdDlWlMl4FIg\nRE3KCM8RgMP9Abi9AAR57ps76VXjkwGNHFrGSjRC6dOB3N2xi7q4S7LImRLMgOuO\nEew0blnzyQDE4AW5pvVHHSk=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "momt-android@quixotic-booth-281410.iam.gserviceaccount.com",
      "client_id": "111069666172392747993",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/momt-android%40quixotic-booth-281410.iam.gserviceaccount.com"
    });
    var scopes = ["https://www.googleapis.com/auth/cloud-vision"];

    var client = http.Client();
    AccessCredentials credentials =
        await obtainAccessCredentialsViaServiceAccount(
            accountCredentials, scopes, client);

    client.close();
    return credentials.accessToken.data;
  }

  Mood parseEmotionsResponse(response) {
    List<Mood> result = [];

    if (!response["responses"][0]["faceAnnotations"][0]["joyLikelihood"]
        .toString()
        .toUpperCase()
        .contains("UNLIKELY")) result.add(Mood.JOY);

    if (!response["responses"][0]["faceAnnotations"][0]["sorrowLikelihood"]
        .toString()
        .toUpperCase()
        .contains("UNLIKELY")) result.add(Mood.SORROW);

    if (!response["responses"][0]["faceAnnotations"][0]["angerLikelihood"]
        .toString()
        .toUpperCase()
        .contains("UNLIKELY")) result.add(Mood.ANGER);

    if (!response["responses"][0]["faceAnnotations"][0]["surpriseLikelihood"]
        .toString()
        .toUpperCase()
        .contains("UNLIKELY")) result.add(Mood.SURPRISE);

    print(
        "Expression joyLikelihood ${response["responses"][0]["faceAnnotations"][0]["joyLikelihood"]}");
    print(
        "Expression sorrowLikelihood ${response["responses"][0]["faceAnnotations"][0]["sorrowLikelihood"]}");
    print(
        "Expression angerLikelihood ${response["responses"][0]["faceAnnotations"][0]["angerLikelihood"]}");
    print(
        "Expression surpriseLikelihood ${response["responses"][0]["faceAnnotations"][0]["surpriseLikelihood"]}");
    print('Hi respo $result');
    return result.isEmpty ? Mood.ANGER : result[0];
  }
}
