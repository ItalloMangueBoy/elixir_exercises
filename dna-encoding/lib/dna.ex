defmodule DNA do
  @type encoded_nucleotide :: 0 | 1 | 2 | 4 | 8
  @type decoded_nucleotide :: 32 | 65 | 67 | 71 | 84

  @spec encode_nucleotide(decoded_nucleotide()) :: encoded_nucleotide()
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  @spec decode_nucleotide(encoded_nucleotide()) :: decoded_nucleotide()
  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  @spec encode(charlist()) :: bitstring()
  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], acc), do: acc

  defp do_encode([nucleotide | dna_rest], acc) do
    encoded_dna = <<acc::bitstring, encode_nucleotide(nucleotide)::4>>

    do_encode(dna_rest, encoded_dna)
  end

  @spec decode(bitstring()) :: charlist()
  def decode(dna), do: do_decode(dna, ~c"")

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<nucleotide::4, dna_rest::bitstring>>, acc) do
    decoded_dna = acc ++ [decode_nucleotide(nucleotide)]

    do_decode(dna_rest, decoded_dna)
  end
end
