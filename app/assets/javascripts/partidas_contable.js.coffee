# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  llenarBanco = (bancos) ->
    empresa = $('#partida_contable_empresa_id :selected').text()
    options = $(bancos).filter("optgroup[label='#{empresa}']").html()
    if options
      $('#partida_contable_banco_id').html('<option value="">Seleccione un banco...</option>')
      $('#partida_contable_banco_id').append(options)
    else
      $('#partida_contable_banco_id').empty()

  bancos = $('#partida_contable_banco_id').html()
  llenarBanco bancos
  $('#partida_contable_empresa_id').change ->
    llenarBanco bancos