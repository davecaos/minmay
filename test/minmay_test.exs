defmodule MinmayTest do
  use ExUnit.Case, async: true

  describe "from_extension/1" do
    test "returns correct MIME type for known extensions" do
      assert Minmay.from_extension(".jpg") == "image/jpeg"
      assert Minmay.from_extension(".html") == "text/html"
      assert Minmay.from_extension(".png") == "image/png"
      assert Minmay.from_extension(".mp4") == "video/mp4"
      assert Minmay.from_extension(".pdf") == "application/pdf"
      assert Minmay.from_extension(".json") == "application/json"
      assert Minmay.from_extension(".css") == "text/css"
    end

    test "returns nil for unknown extension" do
      assert Minmay.from_extension(".nonexistent") == nil
      assert Minmay.from_extension("") == nil
    end

    test "preserves original data casing" do
      assert Minmay.from_extension(".AAC") == "audio/aac"
      assert Minmay.from_extension(".ADTS") == "audio/aac"
    end
  end

  describe "from_filename/1" do
    test "extracts extension and looks up MIME type" do
      assert Minmay.from_filename("vacation.jpg") == "image/jpeg"
      assert Minmay.from_filename("report.pdf") == "application/pdf"
      assert Minmay.from_filename("/absolute/path/to/video.mp4") == "video/mp4"
    end

    test "returns nil for unknown file extension" do
      assert Minmay.from_filename("archive.xyz") == nil
    end

    test "returns nil for file with no extension" do
      assert Minmay.from_filename("Makefile") == nil
    end
  end

  describe "from_mime_type/1" do
    test "returns correct extension for known MIME types" do
      assert Minmay.from_mime_type("image/jpeg") == ".jpg"
      assert Minmay.from_mime_type("text/html") == ".html"
      assert Minmay.from_mime_type("video/mp4") == ".mp4"
      assert Minmay.from_mime_type("application/msword") == ".doc"
    end

    test "returns nil for unknown MIME type" do
      assert Minmay.from_mime_type("application/fake") == nil
    end
  end

  test "all extensions/0 entries are retrievable via from_extension/1" do
    for {ext, mime} <- Minmay.extensions() do
      assert Minmay.from_extension(ext) == mime,
             "Expected from_extension(#{inspect(ext)}) == #{inspect(mime)}"
    end
  end

  test "all extensions/0 entries are retrievable via from_filename/1" do
    for {ext, mime} <- Minmay.extensions() do
      assert Minmay.from_filename("file" <> ext) == mime,
             "Expected from_filename for ext #{inspect(ext)} == #{inspect(mime)}"
    end
  end

  test "all mime_types/0 entries are retrievable via from_mime_type/1" do
    for {mime, ext} <- Minmay.mime_types() do
      assert Minmay.from_mime_type(mime) == ext,
             "Expected from_mime_type(#{inspect(mime)}) == #{inspect(ext)}"
    end
  end

  test "random sample of 1000 extensions resolves correctly" do
    all = Minmay.extensions()
    len = length(all)

    for _ <- 1..1_000 do
      {ext, mime} = Enum.at(all, :rand.uniform(len) - 1)
      assert Minmay.from_extension(ext) == mime
    end
  end

  test "random sample of 1000 MIME types resolves correctly" do
    all = Minmay.mime_types()
    len = length(all)

    for _ <- 1..1_000 do
      {mime, ext} = Enum.at(all, :rand.uniform(len) - 1)
      assert Minmay.from_mime_type(mime) == ext
    end
  end

  test "start/0 and stop/0 return :ok" do
    assert Minmay.start() == :ok
    assert Minmay.stop() == :ok
    assert Minmay.from_extension(".jpg") == "image/jpeg"
  end

  test "extensions/0 returns a non-empty list of tuples" do
    exts = Minmay.extensions()
    assert is_list(exts)
    assert length(exts) > 500
    {ext, mime} = hd(exts)
    assert is_binary(ext) and is_binary(mime)
  end

  test "mime_types/0 returns a non-empty list of tuples" do
    mimes = Minmay.mime_types()
    assert is_list(mimes)
    assert length(mimes) > 40
  end
end
