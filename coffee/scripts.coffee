$(document).ready ->
	# Foca na caixa de pesquisa ao iniciar
	$("#palavra").focus()

	# Clique do botão
	$('#botao').click ->
		$.get 'http://www.priberam.pt/SimpleDLPO/VistaGadgetDLPO.aspx', { 'pal': escape $('#palavra').val() },  (data) ->
			table = $('table', data)
			table = table[3]
			div = $('div', table)

			# Remove elementos inúteis e vazios
			$('hr', div).remove()
			$('#resultado').empty()
			$('#resultado').css 'height', 'auto'
			$('#resultado').append div
			$('#resultado div:first').remove()
			$('#resultado a').attr 'target', '_blank'


	# Caso o usuário aperte enter, clica o botão
	$('#palavra').keypress (keycode) ->
		if keycode.which is 13
			$('#botao').click()

	# Mostra o gif enquanto carrega
	$('#load_info').ajaxStart ->
		$(@).attr 'class', ''
		$('#resultado').slideUp()
		$(@).html '<img src="images/loading.gif" width="50px" height="50px" />'
		$(@).css('display', 'block');
		$('#palavra').val('');

	# Mostra o resultado se receber a requisição
	$('#load_info').ajaxSuccess ->
		$(@).html ''
		$(@).css 'display', 'none'
		$('#resultado').slideDown()

	# Mostra o erro caso algo errado ocorra na requisição
	$('#load_info').ajaxError ->
		$(@).html ''
		$(@).html 'Oops! Houve um erro ao recuperar o significado da palavra!'
		$(@).attr 'class', 'error'
