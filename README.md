# demoMockFailure

How to demo the failure in https://github.com/intuit/karate/issues/1480:
1. git clone the repo
2. change directry to demoMockFailure 
3. Launch the mock server by specifying different standalone karate-{{version}}.jar
 ```
java -jar karate-{{version}}.jar -m main-mock-server.feature -p 8644
```

1. if use standalone karate-0.9.6.jar,  the mock server could be launched successfully without the failure. And you can also verify the mock server is up and running by typing the url (http://localhost:8644/greeting) in any browser.  
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

2. If use standalone karate-0.9.9.RC4.jar , you will get the same error mentioined in the begining of the thread https://github.com/intuit/karate/issues/1480
```
$ java -jar karate-0.9.9.RC4.jar -m main-mock-server.feature -p 8644
11:41:24.342 [main]  INFO  com.intuit.karate - Karate version: 0.9.9.RC4
11:41:25.639 [main]  INFO  com.intuit.karate - [print] Run background only once... 
11:41:25.656 [main]  ERROR com.intuit.karate - mock-server background failed - main-mock-server.feature:5
com.intuit.karate.KarateException: mock-server background failed - main-mock-server.feature:5
        at com.intuit.karate.core.MockHandler.<init>(MockHandler.java:104)
        at com.intuit.karate.core.MockServer$Builder.build(MockServer.java:107)
        at com.intuit.karate.Main.call(Main.java:384)
        at com.intuit.karate.Main.call(Main.java:57)
        at picocli.CommandLine.executeUserObject(CommandLine.java:1933)
        at picocli.CommandLine.access$1200(CommandLine.java:145)
        at picocli.CommandLine$RunLast.executeUserObjectOfLastSubcommandWithSameParent(CommandLine.java:2332)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2326)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2291)
        at picocli.CommandLine$AbstractParseResultHandler.execute(CommandLine.java:2159)
        at picocli.CommandLine.execute(CommandLine.java:2058)
        at com.intuit.karate.Main.main(Main.java:291)
Caused by: com.intuit.karate.KarateException: >>>> js failed:
01: read('karate-config.js')
<<<<
org.graalvm.polyglot.PolyglotException: java.io.FileNotFoundException: null/karate-config.js (No such file or directory)
- com.intuit.karate.resource.FileResource.getStream(FileResource.java:94)
- com.intuit.karate.core.ScenarioFileReader.readFileAsStream(ScenarioFileReader.java:101)
- com.intuit.karate.core.ScenarioFileReader.readFileAsString(ScenarioFileReader.java:97)
- com.intuit.karate.core.ScenarioFileReader.readFile(ScenarioFileReader.java:57)
- com.intuit.karate.core.ScenarioEngine.lambda$new$0(ScenarioEngine.java:115)
- <js>.:program(Unnamed:1)

main-mock-server.feature:5
        at <feature>.: * call read('karate-config.js') (main-mock-server.feature:5:5)
```

3. Standalone karate-2.0.0.jar in this repo was build on top of the karate-0.9.9.RC4.jar with the fixing tasks integrated for fixing above failure, by following  https://github.com/intuit/karate/wiki/Developer-Guide, when launching the mock server, you will got the error java.lang.NullPointerException, which is also mentioned in the end of the thread https://github.com/intuit/karate/issues/1480
```
$ java -jar karate-2.0.0.jar -m main-mock-server.feature -p 8644
11:41:46.420 [main]  INFO  com.intuit.karate - Karate version: 2.0.0
11:41:47.715 [main]  INFO  com.intuit.karate - [print] Run background only once... 
11:41:47.751 [main]  INFO  com.intuit.karate - karate.env system property was:  uat 
11:41:47.751 [main]  INFO  com.intuit.karate - karate.server system property was:  localhost 
11:41:47.782 [main]  ERROR com.intuit.karate - mock-server background failed - main-mock-server.feature:6
com.intuit.karate.KarateException: mock-server background failed - main-mock-server.feature:6
        at com.intuit.karate.core.MockHandler.<init>(MockHandler.java:104)
        at com.intuit.karate.core.MockServer$Builder.build(MockServer.java:107)
        at com.intuit.karate.Main.call(Main.java:384)
        at com.intuit.karate.Main.call(Main.java:57)
        at picocli.CommandLine.executeUserObject(CommandLine.java:1933)
        at picocli.CommandLine.access$1200(CommandLine.java:145)
        at picocli.CommandLine$RunLast.executeUserObjectOfLastSubcommandWithSameParent(CommandLine.java:2332)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2326)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2291)
        at picocli.CommandLine$AbstractParseResultHandler.execute(CommandLine.java:2159)
        at picocli.CommandLine.execute(CommandLine.java:2058)
        at com.intuit.karate.Main.main(Main.java:291)
Caused by: com.intuit.karate.KarateException: java.lang.NullPointerException
main-mock-server.feature:6
        at <feature>.: * call read('utils/utils.feature') (main-mock-server.feature:6:6)
```
