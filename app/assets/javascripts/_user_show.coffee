# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#common_academy_id').change ->
    $.ajax get_specialties_path,
      type: 'POST'
      data: { academy_id: $(this).val() }

  $('#common_specialty_id').change ->
    $.ajax get_grades_path,
      type: 'POST'
      data: { specialty_id: $(this).val() }

