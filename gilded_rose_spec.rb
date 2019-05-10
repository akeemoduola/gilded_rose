require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
  	let(:name) { 'foo' }
  	let(:sell_in) { 0 }
  	let(:quality) { 0 }
  	let(:max_quality) { 50 }
  	let(:item) { Item.new(name, sell_in, quality)}
  	let(:items) { [item] }

  	before do
      GildedRose.new(items).update_quality()
  	end

    it 'does not change the name' do
      expect(items[0].name).to eq 'foo'
    end

    it 'does not make quality negative' do
    	expect(items[0].quality).to_not be_negative
    end

    context 'when everyday item' do
	    it 'reduces sell_in by 1 ' do
	      expect(items[0].sell_in).to eq(sell_in - 1)
	    end

	    context 'item quality' do
	    	context 'before selling date' do
	    		let(:sell_in) { 1 }
  				let(:quality) { 2 }

  				it 'reduces quality by 1' do
		    		expect(items[0].quality).to eq(quality - 1)
	    		end
	    	end

	    	context 'on selling date' do
	    		let(:sell_in) { 0 }
  				let(:quality) { 2 }

  				it 'reduces quality by 2' do
		    		expect(items[0].quality).to eq(quality - 2)
	    		end
	    	end

	    	context 'after selling date' do
	    		let(:sell_in) { -1 }
  				let(:quality) { 3 }

  				it 'reduces quality by 2' do
		    		expect(items[0].quality).to eq(quality - 2)
	    		end
	    	end
    	end
	  end

	  context 'when Aged Brie' do
	  	let(:name) { 'Aged Brie' }
	    it 'reduces sell_in by 1 ' do
	      expect(items[0].sell_in).to eq(sell_in - 1)
	    end

	    context 'item quality' do
	    	context 'before selling date' do
	    		let(:sell_in) { 1 }
  				let(:quality) { 2 }

  				it 'increases quality by 1' do
		    		expect(items[0].quality).to eq(quality + 1)
	    		end

	    		context 'and quality is max allowed' do
	    			let(:quality) { 50 }

	  				it 'increases quality by 1' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end

	    	end

	    	context 'on selling date' do
	    		let(:sell_in) { 0 }
  				let(:quality) { 2 }

  				it 'increases quality by 2' do
		    		expect(items[0].quality).to eq(quality + 2)
	    		end

	    		context 'and quality is near max allowed' do
	    			let(:quality) { 49 }

	  				it 'increases quality by 1' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end

	    		context 'and quality is max allowed' do
	    			let(:quality) { 50 }

	  				it 'increases quality by 1' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end
	    	end

	    	context 'after selling date' do
	    		let(:sell_in) { -1 }
  				let(:quality) { 3 }

  				it 'increases quality by 2' do
		    		expect(items[0].quality).to eq(quality + 2)
	    		end

	    		context 'and quality is near max allowed' do
	    			let(:quality) { 49 }

	  				it 'increases quality by 1' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end

	    		context 'and quality is max allowed' do
	    			let(:quality) { 50 }

	  				it 'increases quality by 1' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end
	    	end
    	end
	  end

	  context 'when Sulfuras' do
	  	let(:name) { 'Sulfuras, Hand of Ragnaros' }
	  	let(:sell_in) { 10 }
  		let(:quality) { 80 }

	    it 'does not alter sell_in' do
	      expect(items[0].sell_in).to eq sell_in
	    end

	    context 'item quality' do
	    	context 'before selling date' do
	    		it 'does not change' do
		    		expect(items[0].quality).to eq quality
	    		end
	    	end

	    	context 'on selling date' do
	    		let(:sell_in) { 0 }

  				it 'does not change' do
		    		expect(items[0].quality).to eq quality
	    		end
	    	end

	    	context 'after selling date' do
	    		let(:sell_in) { -1 }

  				it 'does not change' do
		    		expect(items[0].quality).to eq quality
	    		end
	    	end
    	end
	  end

	  context 'when Backstage passes' do
	  	let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
	    it 'reduces sell_in by 1 ' do
	      expect(items[0].sell_in).to eq(sell_in - 1)
	    end

	    context 'item quality' do
	    	context 'before selling date' do
	    		let(:sell_in) { 15 }
  				let(:quality) { 2 }

  				it 'increases by 1' do
		    		expect(items[0].quality).to eq(quality + 1)
	    		end

	    		context 'and if quality is max allowed' do
	    			let(:quality) { 50 }

	  				it 'does not change quality' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end

	    	end

	    	context 'close to selling date' do
	    		let(:sell_in) { 10 }
  				let(:quality) { 3 }

  				it 'increases by 2' do
		    		expect(items[0].quality).to eq(quality + 2)
	    		end

	    		context 'and if quality is near max allowed' do
	    			let(:quality) { 49 }

	  				it 'increases quality to max' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end

	    		context 'and if quality is max allowed' do
	    			let(:quality) { 50 }

	  				it 'does not change quality' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end
	    	end

	    	context 'closer to selling date' do
	    		let(:sell_in) { 5 }
  				let(:quality) { 3 }

  				it 'increases by 3' do
		    		expect(items[0].quality).to eq(quality + 3)
	    		end

	    		context 'and if quality is near max allowed' do
	    			let(:quality) { 49 }

	  				it 'increases quality to max' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end

	    		context 'and if quality is max allowed' do
	    			let(:quality) { 50 }

	  				it 'does not change quality' do
			    		expect(items[0].quality).to eq max_quality
		    		end
	    		end
	    	end

	    	context 'after selling date' do
	    		let(:sell_in) { -1 }
  				let(:quality) { 2 }

  				it 'sets quality to zero' do
		    		expect(items[0].quality).to be_zero
	    		end
	    	end
    	end
	  end

	  context 'when Conjured' do
	  	let(:name) { 'Conjured Mana Cake' }
	  	let(:sell_in) { 10 }
  		let(:quality) { 20 }

	    it 'reduces sell_in by 1' do
	      expect(items[0].sell_in).to eq(sell_in - 1)
	    end

	    context 'item quality' do
	    	context 'before selling date' do
	    		it 'reduces quality by 2' do
		    		expect(items[0].quality).to eq(quality - 2)
	    		end

	    		context 'sets quality to zero if deduction gives negative' do
	    			let(:quality) { 1 }

		    		it 'does not make quality negative' do
				    	expect(items[0].quality).to_not be_negative
				    end
				  end
	    	end

	    	context 'on selling date' do
	    		let(:sell_in) { 0 }

  				it 'reduces quality by 4' do
		    		expect(items[0].quality).to eq(quality - 4)
	    		end

	    		context 'sets quality to zero if deduction gives negative' do
	    			let(:quality) { 2 }

		    		it 'does not make quality negative' do
				    	expect(items[0].quality).to_not be_negative
				    end
				  end
	    	end

	    	context 'after selling date' do
	    		let(:sell_in) { -1 }

  				it 'reduces quality by 4' do
		    		expect(items[0].quality).to eq(quality - 4)
	    		end

	    		context 'sets quality to zero if deduction gives negative' do
	    			let(:quality) { 1 }

		    		it 'does not make quality negative' do
				    	expect(items[0].quality).to_not be_negative
				    end
				  end
	    	end
    	end
	  end
  end
end
