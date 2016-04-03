# $ ->
#   'use strict'
#   $(document).on 'pageInit', '#userEditPage', (e, id, page) ->
#     $('#common_academy_id').change ->
#       $.ajax 
#         url: get_specialties_path
#         beforeSend: (xhr) -> 
#           xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
#         type: 'POST'
#         data: { academy_id: $(this).val() }

#     $('#common_specialty_id').change ->
#       $.ajax 
#         url: get_grades_path
#         beforeSend: (xhr) -> 
#           xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
#         type: 'POST'
#         data:  { specialty_id: $(this).val() }
#     return

#   $.init()
#   return