class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item_type = ITEM_TYPES[item.name]
      if item_type
        item_type.new.update(item)
      else
        DefaultItem.new.update(item)
      end
    end
  end
end

class DefaultItem
  def update(item)
    update_quality(item)
    update_sell_in(item)
  end

  def update_quality(item)
    item.quality = item.sell_in <= 0 ? item.quality - 2 : item.quality - 1
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.quality < 0
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
end

class AgedBrie
  def update(item)
    update_quality(item)
    update_sell_in(item)
  end

  def update_quality(item)
    item.quality = item.sell_in <= 0 ? item.quality + 2 : item.quality + 1
    item.quality = 50 if item.quality > 50
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
end

class Sulfuras
  def update(item)
  end
end

class Backstage
  def update(item)
    update_quality(item)
    update_sell_in(item)
  end

  def update_quality(item)
    item.quality += 1 if item.sell_in > 10
    item.quality += 2 if item.sell_in <= 10
    item.quality += 1 if item.sell_in <= 5
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.sell_in < 0 || item.quality < 0
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
end

class Conjured
  def update(item)
    update_quality(item)
    update_sell_in(item)
  end

  def update_quality(item)
    item.quality = item.sell_in <= 0 ? item.quality - 4 : item.quality - 2
    item.quality = 0 if item.quality < 0
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
end

ITEM_TYPES = {
  "Aged Brie" => AgedBrie,
  "Sulfuras, Hand of Ragnaros" => Sulfuras,
  "Backstage passes to a TAFKAL80ETC concert" => Backstage,
  "Conjured Mana Cake" => Conjured,
  }

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
