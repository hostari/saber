require "http/params"

class Saber::ParamsBuilder < HTTP::Params::Builder
  def add(key, value : Array(String))
    value.each_with_index do |v, i|
      add("#{key}[#{i}]", v.to_s)
    end
  end

  def add(key, value : Array(Hash(K, V) | NamedTuple)) forall K, V
    value.each_with_index do |v, i|
      add("#{key}[#{i}]", v)
    end
  end

  def add(key, value : Int32 | Int64 | Bool)
    add(key, value.to_s)
  end

  def add(key, value : Hash | NamedTuple)
    value.each do |k, v|
      if v.nil?
        # Skip nil values
      else
        _key = "#{key}[#{k}]"

        case v
        when Enum then add(_key, v.to_s.underscore)
        else           add(_key, v.to_s)
        end
      end
    end

    self
  end
end
