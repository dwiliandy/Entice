// import 'core-js/stable'
// import 'regenerator-runtime/runtime'
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// import {} from 'jquery-ujs'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



// import "../stylesheets/application"
// import 'core-js/stable'
// import 'regenerator-runtime/runtime'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
require("css/application")
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
import "@fortawesome/fontawesome-free/js/all"
require('./owl.carousel.min')
require('./jquery.nice-select')
require('./jquery-ui.min')
require('./jquery.slicknav')
require('./main')
require("chartkick")
require("chart.js")
