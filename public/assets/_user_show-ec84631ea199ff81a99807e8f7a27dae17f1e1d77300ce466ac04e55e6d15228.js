(function(){$(function(){return $("#common_academy_id").change(function(){return $.ajax(get_specialties_path,{type:"POST",data:{academy_id:$(this).val()}})}),$("#common_specialty_id").change(function(){return $.ajax(get_grades_path,{type:"POST",data:{specialty_id:$(this).val()}})})})}).call(this);