<footer>
  <div class="container">
    <div class="row py-5 px-0">
      <div class="col-12 col-xl-3 col-lg-3 col-md-6 col-sm-12 mb-3 vcard">
        <p>連絡先メールアドレス</p>
        <a class="w-100 email stopPromotion" href="mailto:tung.42@gmail.com">tung.42@gmail.com</a>
        <p class="mt-3">著作権 <i class="fal fa-copyright"></i> {{ date('Y') }} <a class="url fn h-card stopPromotion" target="_blank" href="https://tungpham42.github.io/">Tung Pham</a></p>
      </div>
      <div class="col-12 col-xl-3 col-lg-3 col-md-6 col-sm-12 mb-3">
        <ul class="list-unstyled">
          <li>
            <a class="home stopPromotion" href="{{ url('/ja') }}"><i class="fal fa-home-lg-alt"></i> ホームページ</a>
          </li>
          <li>
            <a class="room stopPromotion rooms-list" href="{{ url('/heya-ichiran') }}"><i class="fal fa-list-alt"></i> 部屋一覧</a>
          </li>
          <li>
            <a class="setup puzzle stopPromotion" href="{{ url('/pazuru') }}"><i class="fal fa-puzzle-piece"></i> パズル</a>
          </li>
          <li>
            <a class="about stopPromotion" href="{{ url('/yaku') }}"><i class="fal fa-info-square"></i> 約</a>
          </li>
          <li>
            <a class="contact stopPromotion" href="{{ url('/kontakuto') }}"><i class="fal fa-envelope"></i> コンタクト</a>
          </li>
          <li>
            <a target="_blank" class="game stopPromotion" href="https://game.cotuong.top"><i class="fal fa-gamepad-alt"></i> ゲーム</a>
          </li>
          <li>
            <a target="_blank" class="chat stopPromotion" href="https://chat.cotuong.top"><i class="fal fa-comment-lines"></i> チャットボックス</a>
          </li>
          <li>
            <a target="_blank" class="buy stopPromotion" href="https://www.codester.com/items/41601/multilingual-chinese-chess-game-with-many-options?ref=tungpham"><i class="fal fa-shopping-cart"></i> 買う</a>
          </li>
          <li>
            <a target="_blank" class="2048 stopPromotion" href="https://nhipsinhhoc.vn/ja/"><i class="fal fa-head-side-medical"></i> バイオリズム</a>
          </li>
          <li>
            <a class="lang stopPromotion" href="{{ url($langViUrl) }}"><span class="fi fi-vn"></span> Tiếng Việt</a>
          </li>
          <li>
            <a class="lang stopPromotion" href="{{ url($langEnUrl) }}"><span class="fi fi-us"></span> English</a>
          </li>
          <li>
            <a class="lang stopPromotion" href="{{ url($langKoUrl) }}"><span class="fi fi-kr"></span> 한국어</a>
          </li>
          <li>
            <a class="lang stopPromotion" href="{{ url($langZhUrl) }}"><span class="fi fi-cn"></span> 中文</a>
          </li>
        </ul>
      </div>
      <div class="col-12 col-xl-3 col-lg-3 col-md-6 col-sm-12 mb-3">
        <p>ソーシャルメディアで私たちを見つけてください</p>
        <a class="w-100 mr-2 display-4 stopPromotion" target="_blank" href="https://www.youtube.com/@CoTuongVlog/videos"><i class="fab fa-youtube"></i></a>
        <a class="w-100 mr-2 display-4 stopPromotion" target="_blank" href="https://www.facebook.com/CoTuongPage/"><i class="fab fa-facebook-square rounded"></i></a>
        <a class="w-100 mr-2 display-4 stopPromotion" target="_blank" href="https://www.linkedin.com/company/cotuong/"><i class="fab fa-linkedin rounded"></i></a>
      </div>
      <div class="col-12 col-xl-3 col-lg-3 col-md-6 col-sm-12 mb-3">
        <p>HTML5 および CSS3 で検証済み</p>
        <a title="Valid HTML5" class="w-100 mr-2 display-4 text-decoration-none stopPromotion" target="_blank" href="https://validator.w3.org/check?uri=referer">
          <i class="fab fa-html5"></i>
        </a>
        <a title="Valid CSS3" class="w-100 mr-2 display-4 text-decoration-none stopPromotion" target="_blank" href="https://jigsaw.w3.org/css-validator/check/referer">
          <i class="fab fa-css3-alt"></i>
        </a>
      </div>
    </div>
  </div>
</footer>
<script>
// if (window.location.pathname == '/en') {
//   $('#ShopeeModal').modal('show');
// }
$('#undo, #reset, #resign').each(function(){
  $(this).on('click', function(){
    window.scrollTo({ top: 0 });
  });
});
$('.menu-toggle').on('click', function(){
  $(this).toggleClass('open close');
});
if (!$('#ads').find('ins').attr('data-ad-status')) {
  $('#ads').find('ins').attr('data-ad-status', 'unfilled');
}
if (!$('#topAds').find('ins').attr('data-ad-status')) {
  $('#topAds').find('ins').attr('data-ad-status', 'unfilled');
}
if (!$('#sideAds').find('ins').attr('data-ad-status')) {
  $('#sideAds').find('ins').attr('data-ad-status', 'unfilled');
}
$('.showPromotion').each(function(){
  $(this).on('click auxclick', function(e){
    if (removeTrailingSlash($(this).attr('href')) !== removeTrailingSlash(window.location.href)) {
      e.preventDefault();
      $('#AdSenseModal').attr('data-url', $(this).attr('href')).modal('show');
    } else {
      window.location.href = $(this).attr('href');
    }
  });
});
$('#AdSenseModal').on('show.bs.modal', function(){
  if (!$('#AdSenseModal').find('ins').attr('data-ad-status')) {
    $('#AdSenseModal').find('ins').attr('data-ad-status', 'unfilled');
  }
}).on('shown.bs.modal', function() {
  $('#adModalCloseBtn').attr('data-original-title', '行く先: ' + $(this).attr('data-url')).css('cursor', 'wait').prop('disabled', true);
  $('#adModalCloseBtn').tooltip();
  let i = 2;
  let timer = setInterval(function() {
    console.log(--i);
    $('#adModalCloseBtn').find('span').text(i + '秒');
    if (i === -1) {
      $('#adModalCloseBtn').find('i').removeClass('fa-clock').addClass('fa-link');
      $('#adModalCloseBtn').css('cursor', 'pointer').removeClass('disabled').removeAttr('disabled').addClass('pulse-red').find('span').text('行こう');
      clearInterval(timer);
    }
  }, 1000);
}).on('hidden.bs.modal', function() {
  $('#adModalCloseBtn').find('span').text('2秒');
  // window.open($(this).attr('data-url'), '_blank');
  window.location.href = $(this).attr('data-url');
});
$(function () {
  $('.btn-dark').each(function(){
    $(this).on('mouseenter mouseleave', function(){
      $(this).toggleClass('btn-dark btn-danger');
    });
  });
  $('.game .btn, .about .btn').each(function(){
    $(this).on('mouseenter mouseleave', function(){
      $(this).find('i').toggleClass('fad fas');
    });
  });
});
</script>
<a href="#0" class="cd-top js-cd-top rounded" style="background-image: url('{{ $cdnUrl }}/img/cd-top-arrow.svg');">Top</a>
<script src="{{ URL::to('') }}/js/to-top.js"></script>
@include('cookie-consent::index')