requirejs.config({
  baseUrl: 'scripts/',

  paths: {
    easel:    '../bower_components/easeljs/lib/easeljs-0.7.1.min',
    sound:    '../bower_components/soundjs/lib/soundjs-0.5.2.min',
    preload:  '../bower_components/preloadjs/lib/preloadjs-0.4.1.min',
    tween:    '../bower_components/tweenjs/lib/tweenjs-0.5.1.min',
    tweenMax: '../bower_components/greensock/src/minified/TweenMax.min',
    easing:   '../bower_components/greensock/src/minified/EasePack.min',
    easelPlugin: '../bower_components/greensock/src/minified/EaselPlugin.min'
  },

  shim: {
    easel: {
      exports: 'createjs'
    },
    sound: {
      deps: ['easel'],
      exports: 'Sound'
    },
    tween: {
      deps: ['easel'],
      exports: 'Tween'
    },
    preload: {
      deps: ['easel'],
      exports: 'Preload'
    }
  }
});