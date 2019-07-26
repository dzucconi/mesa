# frozen_string_literal: true

Fabricator(:page) do
  title 'Impression, Sunrise'
  namespace { Fabricate(:namespace) }
  slug { |attrs| attrs[:title].parameterize }
  content '
    *Although* it seems that the sun is the brightest spot on the canvas,
    it is in fact, when measured with a photometer, the same brightness
    or [luminance as the sky](http://en.wikipedia.org/wiki/Impression,_Sunrise).

    “If you make a black and white copy of **Impression: Sunrise**, the Sun
    disappears [almost] entirely.”
  '.squish
end
