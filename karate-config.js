function() {
    var env = karate.env; // get system property 'karate.env'
    var server = karate.get(server);
    //default to UAT if not defined
    if (!env) {
        env = 'uat';
    }
    //default to localhost if not defined
    if (!server) {
        server = 'localhost'
    }
    karate.log('karate.env system property was: ', env);
    karate.log('karate.server system property was: ', server);
    var config = {
        env: env
    };

    if (env.toLowerCase() === 'poc') {
        config.env = 'poc'
    } else if (env.toLowerCase() === 'uat') {
        config.env = 'uat'
    }
    config.server = server.toLowerCase();
    return config;
}
