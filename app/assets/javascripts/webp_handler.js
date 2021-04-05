var $supportWebP = true;
async function supportsWebp() {
  if (!self.createImageBitmap) return false;

  const webpData = 'data:image/webp;base64,UklGRh4AAABXRUJQVlA4TBEAAAAvAAAAAAfQ//73v/+BiOh/AAA=';
  const blob = await fetch(webpData).then(r => r.blob());
  return createImageBitmap(blob).then(() => true, () => false);
}

(async () => {
  if(await supportsWebp()) {
    console.log('Support WebP');
  } else {
    $supportWebP = false;
    console.log('Does not support WebP');
    webPFallbackAll();
  }
})();

function webPFallbackAll() {
  if ($supportWebP) {
    $('img[data-webp]').attr('data-webp-checked', true);
    $('section[data-webp]').attr('data-webp-checked', true);
    return true;
  }

  var $webpImgs = $('img[data-webp]').not('[data-webp-checked]');
  $.each($webpImgs, function(i, img) {
    imgWebPFallback($(img));
  });

  var $webpSections = $('section[data-webp]').not('[data-webp-checked]');
  $.each($webpSections, function(i, section) {
    sectionWebPFallback($(section));
  });
}

function imgWebPFallback($img) {
  var fallbackUrl = $img.data('fallback');
  $img.attr('src', fallbackUrl);
  $img.attr('data-webp-checked', true);
}

function sectionWebPFallback($section) {
  var fallbackUrl = $section.data('fallback');

  $section.css('background', 'url('+ fallbackUrl +') center center/cover no-repeat;');
  $section.attr('style', 'background: url('+ fallbackUrl +') center center/cover no-repeat;');
  $section.attr('data-webp-checked', true);
}
