requirejs.config({
  baseUrl: 'scripts/',

  paths: {
    easel:    '../bower_components/easeljs/lib/easeljs-NEXT.min',
    sound:    '../bower_components/soundjs/lib/soundjs-NEXT.min',
    preload:  '../bower_components/preloadjs/lib/preloadjs-NEXT.min',
    tween:    '../bower_components/tweenjs/lib/tweenjs-NEXT.min',
    // tweenMax: '../bower_components/greensock/src/minified/TweenMax.min',
    // easing:   '../bower_components/greensock/src/minified/EasePack.min',
    easelPlugin: '../bower_components/greensock/src/minified/EaselPlugin.min',
    // underscore : '../bower_components/underscore/underscore-min',
    Font: '../bower_components/Font.js/Font'
  },

  shim: {
    Font: {
      exports: 'Font'
    },
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
    },
    // underscore: {
    //   exports: '_'
    // }
  }
});