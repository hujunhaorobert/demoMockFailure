# @ignore
Feature: Not real feature, just a container to collect utils functions

  Scenario:
    * def getDateTime =
    """
    function() {
        var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
        var sdf = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
        var date = new java.util.Date();
        return sdf.format(date);
    }
    """

    * def nextId = function(){ return ~~curId++ } 
