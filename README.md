# demoMockFailure

How to demo the failure in https://github.com/intuit/karate/issues/1517:
1. git clone the repo
2. change directry to demoMockFailure 
3. Launch the mock server by specifying different standalone karate-{{version}}.jar,
 ```
java -jar karate-{{version}}.jar -m main-mock-server.feature -p 8644
```
4. In a seperate terminal window, run the test feature against the mock server, please note: the karate standalone jar version should match the mock server version.
```
java -cp karate-{{version}}.jar:. com.intuit.karate.Main -C MockService-Test.feature
```

Test result #1 :
1. if use standalone karate-0.9.6.jar,  the mock server and test feature could be launched and test case runs successfully without the failure.  
```
$ java -jar karate-0.9.6.jar -m main-mock-server.feature -p 8644
11:32:44.987 [main]  INFO  com.intuit.karate.Main - Karate version: 0.9.6
11:32:45.581 [main]  INFO  com.intuit.karate - [print] Run background ...
11:32:45.657 [main]  INFO  com.intuit.karate - karate.env system property was:  uat 
11:32:45.659 [main]  INFO  com.intuit.karate - karate.server system property was:  localhost 
11:32:45.728 [main]  INFO  com.intuit.karate - backend main-mock-server.feature initialized
11:32:45.728 [main]  INFO  com.intuit.karate - all backends initialized
11:32:50.846 [main]  INFO  c.intuit.karate.netty.FeatureServer - server started - http://127.0.0.1:8644
11:32:54.275 [nioEventLoopGroup-3-2] 1209683016 DEBUG com.intuit.karate - handling method: GET, uri: /greeting
```

2. If use standalone karate-1.0.0.jar or karate-0.9.9.RC4.jar, you will get the error mentioined in the begining of the thread https://github.com/intuit/karate/issues/1517
Launch mock server works well.
```
$ java -jar karate-1.0.0.jar -m main-mock-server.feature -p 8644
```
But the testing againg the mock shows the error:
```
$ java -cp karate-0.9.6.jar:. com.intuit.karate.Main -C MockService-Test.feature
Junhaos-MacBook-Pro:demo junhaohu$ java -cp karate-1.0.0.jar:. com.intuit.karate.Main -C MockService-Test.feature
15:29:07.762 [main]  INFO  com.intuit.karate - Karate version: 1.0.0
15:29:07.923 [main]  INFO  com.intuit.karate - deleted directory: target
15:29:08.159 [main]  DEBUG com.intuit.karate.Suite - [config] classpath:karate-config.js
15:29:08.877 [main]  INFO  com.intuit.karate - karate.env system property was:  uat 
15:29:08.878 [main]  INFO  com.intuit.karate - karate.server system property was:  localhost 
15:29:08.916 [main]  INFO  com.intuit.karate - >> lock acquired, begin callonce: read('classpath:utils/utils.feature')
15:29:08.939 [main]  INFO  com.intuit.karate - << lock released, cached callonce: read('classpath:utils/utils.feature')
15:29:09.161 [main]  DEBUG com.intuit.karate - request:
1 > GET http://localhost:8644/greeting
1 > Host: localhost:8644
1 > Connection: Keep-Alive
1 > User-Agent: Apache-HttpClient/4.5.13 (Java/1.8.0_181)
1 > Accept-Encoding: gzip,deflate


15:29:09.508 [main]  DEBUG com.intuit.karate - response time in milliseconds: 326
1 < 200
1 < content-type: application/json
1 < content-length: 107
1 < server: Armeria/1.4.0
1 < date: Tue, 16 Mar 2021 04:29:09 GMT
{"id":0,"message":"Hello, uat Karate Mock Server is alive in localhost!","timestamp":"16-03-2021 03:29:09"}
15:29:09.516 [main]  INFO  com.intuit.karate - karate.env system property was:  uat 
15:29:09.516 [main]  INFO  com.intuit.karate - karate.server system property was:  localhost 
15:29:09.532 [main]  ERROR com.intuit.karate - org.apache.http.ProtocolException: Target host is not specified, http call failed after 1 milliseconds for url: /greeting
15:29:09.533 [main]  ERROR com.intuit.karate - MockService-Test.feature:16
When method get
http call failed after 1 milliseconds for url: /greeting
MockService-Test.feature:16
---------------------------------------------------------
feature: MockService-Test.feature
scenarios:  2 | passed:  1 | failed:  1 | time: 0.6167
---------------------------------------------------------

15:29:10.266 [main]  INFO  com.intuit.karate.Suite - <<fail>> feature 1 of 1 (0 remaining) MockService-Test.feature
Karate version: 1.0.0
======================================================
elapsed:   2.34 | threads:    1 | thread time: 0.62 
features:     1 | skipped:    0 | efficiency: 0.26
scenarios:    2 | passed:     1 | failed: 1
======================================================
>>> failed features:
http call failed after 1 milliseconds for url: /greeting
MockService-Test.feature:16
<<<
```
