$(document).ready(function () {
  $('.tendina h2').on('click', function () {
    var $tendina = $(this).parent(); // Trova il genitore dell'header

    // Alterna lo stato "active" e mostra/nasconde solo il pannello della tendina cliccata
    $tendina.toggleClass('active');
    $tendina.find('.pannello').slideToggle(300);
  });
  $('.section .page').hide();

  // Aggiunge il comportamento di toggle a ciascun titolo di sezione
  $('.section > h2').click(function () {
    var $section = $(this).parent(); // Seleziona la sezione corrente
    var $pages = $section.find('.page'); // Seleziona tutte le pagine della sezione
    $pages.slideToggle(); // Mostra o nasconde tutte le pagine con animazione
    $(this).toggleClass('active'); // Aggiunge/rimuove una classe per indicare lo stato

    // Aggiunge un pulsante "Torna al titolo" se non è già presente
    if ($pages.is(':visible') && !$section.find('.ritorna').length) {
      $pages.append('<button class="ritorna">Torna al titolo</button>');
    }
  });

  // Comportamento per il pulsante "Torna al titolo"
  $(document).on('click', '.ritorna', function () {
    var $section = $(this).closest('.section'); // Trova la sezione corrente
    $('html, body').animate(
      {
        scrollTop: $section.offset().top, // Scorri fino al titolo della sezione
      },
      500 // Velocità dello scroll
    );
  });

  $("[id='sic']").on("click", function () {
    $(this).next("[id='corr']").toggle(); // Cambia la visibilità dell'elemento successivo
});


// Aggiungi il gestore dell'evento clic al bottone
  $('#mostraextra').click(function () {
    // Alterna la classe 'show-effects' al body o a un container specifico
    $('body').toggleClass('mostra');

    // Modifica il testo del bottone per indicare lo stato
    var isActive = $('body').hasClass('mostra');
    $(this).text(isActive ? 'Nascondi Infomazioni' : 'Mostra Informazioni');
  });



  $('.gloss').hide();

  // Aggiunge il comportamento a tendina solo agli h3 dentro una div con classe "glossario"
  $('.glossario h3').click(function () {
    var $gloss = $(this).next('.gloss'); // Trova la sezione "gloss" associata
    $gloss.slideToggle(300); // Mostra o nasconde con animazione
    $(this).toggleClass('active'); // Aggiunge/rimuove una classe per il titolo attivo
  });
});


