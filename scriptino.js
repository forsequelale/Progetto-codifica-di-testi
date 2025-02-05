$(document).ready(function () {

  //blocchi testo collegati all'immagine
  $('.zone').on('click', function() {
    var facs = $(this).data('facs'); 
  
    if (facs) {
      $('.blocco').removeClass('highlight');  // rimuove la classe highlight da tutti i blocchi
      $(facs).addClass('highlight');  // aggiunge la classe highlight al blocco cliccato
      
      $('html, body').animate({
        scrollTop: $(facs).offset().top 
      }, 500); 
    }
  });

  //menù informazioni
  $('.tendina h2').on('click', function () {
    var $tendina = $(this).parent(); 
    $tendina.toggleClass('active');
    $tendina.find('.pannello').slideToggle(300);
  });
  $('.section .page').hide();

  //menù articoli
  $('.section > h2').click(function () {
    var $section = $(this).parent(); 
    var $pages = $section.find('.page'); // seleziona tutte le pagine della sezione
    $pages.slideToggle(); 
    $(this).toggleClass('active'); 

    //pulsante "Torna al titolo" 
    if ($pages.is(':visible') && !$section.find('.ritorna').length) {
      $pages.append('<button class="ritorna">Torna al titolo</button>');
    }
  });

  $(document).on('click', '.ritorna', function () {
    var $section = $(this).closest('.section'); 
    $('html, body').animate(
      {
        scrollTop: $section.offset().top, // scorri fino al titolo della sezione
      },
      500 
    );
  });

  //visualizza correzioni
  $("[id='sic']").on("click", function () {
    $(this).next("[id='corr']").toggle();
  });

  // info extra
  $('#mostraextra').click(function () {
    $('body').toggleClass('mostra');
    var isActive = $('body').hasClass('mostra');
    $(this).text(isActive ? 'Nascondi Informazioni' : 'Mostra Informazioni');
  });

  //menù glossario
  $('.gloss').hide();
  $('.glossario h3').click(function () {
    var $gloss = $(this).next('.gloss');
    $gloss.slideToggle(300); 
    $(this).toggleClass('active');
  });
});
