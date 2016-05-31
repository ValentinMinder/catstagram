# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#addTag").bind "click", ->
      $("#tags").append($("#new_tag_form").html())

  @removeTag = (element) ->
    element.parent().remove()
