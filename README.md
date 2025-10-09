# minmay

[![Hex.pm](https://img.shields.io/hexpm/v/minmay.svg?style=flat-square)](https://hex.pm/packages/minmay)
[![License](http://img.shields.io/hexpm/l/minmay.svg?style=flat)](https://hex.pm/packages/minmay)
[![Hex.pm](https://img.shields.io/hexpm/dt/minmay.svg?style=flat-square)](https://hex.pm/packages/minmay)

![GIF](http://1.bp.blogspot.com/-yHRkA0tfIds/T8--B9NF1bI/AAAAAAAAC9k/_XLHURp5BeE/s1600/Lynn+Minmay+-+Shao+Pai+Ron.gif)

Minmay is an Elixir library for mapping a file extension to MIME type or vice versa.

It was based in [@samuelneff's](https://github.com/samuelneff/) [MimeTypeMap](https://github.com/samuelneff/MimeTypeMap)

## Installation

Add `minmay` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:minmay, "~> 2.0"}]
end
```

## Usage

```elixir
iex> Minmay.from_extension(".jpg")
"image/jpeg"

iex> Minmay.from_filename("vacations.jpg")
"image/jpeg"

iex> Minmay.from_mime_type("image/jpeg")
".jpg"
```

No `start/0` call is required — the library works immediately.
