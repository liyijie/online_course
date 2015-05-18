# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#user_academy_id').change ->
    $.ajax '/user/get_specialties',
      type: 'POST'
      data: { academy_id: $(this).val() }

  $('#user_specialty_id').change ->
    $.ajax '/user/get_grades',
      type: 'POST'
      data: { specialty_id: $(this).val() }

