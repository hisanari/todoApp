# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->
  $('.datepicker').pickadate(
    today: '',
    clear: '',
    min: Date.now,
    format: 'yyyy-mm-dd',
    formatSubmit: 'yyyy-mm-dd',
    hiddenName: true
  )