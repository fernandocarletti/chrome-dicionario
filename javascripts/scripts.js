$(document).ready(function() {
	// Clique do botão
	$('#botao').click(function() {
		$.get('http://www.priberam.pt/SimpleDLPO/VistaGadgetDLPO.aspx', { 'pal': $('#palavra').val() },  function(data) {
			var table = $('table', data);
			table = table[3];
			var div = $('div', table);

			// Remove elementos inúteis e vazios
			$('hr', div).remove();
			$('#resultado').empty();
			$('#resultado').css('height', 'auto');
			$('#resultado').append(div);
			$('#resultado div:first').remove();
			$('#resultado div:first').remove();
			$('#resultado div:first').remove();
			$('#resultado a').attr('target', '_blank');
		});
	});

	// Caso o usuário aperte enter, clica o botão
	$('#palavra').keypress(function(keycode) {
		if(keycode.which == 13)
		{
			$('#botao').click();
		}
	});

	$('#load_info').ajaxStart(function() {
		$(this).attr('class', '');
		$('#resultado').slideUp();
		$(this).html('<img src="images/loading.gif" width="50px" height="50px" />');
		$(this).css('display', 'block');
		$('#palavra').val('');
	});

	$('#load_info').ajaxSuccess(function() {
		$(this).html('');
		$(this).css('display', 'none');
		$('#resultado').slideDown();
	});

	$('#load_info').ajaxError(function() {
		$(this).html('');
		$(this).html('Oops! Houve um erro ao recuperar o significado da palavra!');
		$(this).attr('class', 'error');
	});
});