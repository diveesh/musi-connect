class MultiTableUpdate1 < ActiveRecord::Migration
    def up
        down

        alto_sax = Instrument.new(:name => "Saxophone, alto")
        alto_sax.save(:validate => false)
        tenor_sax = Instrument.new(:name => "Saxophone, tenor")
        tenor_sax.save(:validate => false)
        other_sax = Instrument.new(:name => "Saxophone, other")
        other_sax.save(:validate => false)
        f_horn = Instrument.new(:name => "French Horn/Mellophone")
        f_horn.save(:validate => false)
        clar = Instrument.new(:name => "Clarinet")
        clar.save(:validate => false)
        flute = Instrument.new(:name => "Flute")
        flute.save(:validate => false)
        piano = Instrument.new(:name => "Piano")
        piano.save(:validate => false)
        accordion = Instrument.new(:name => "Accordion")
        accordion.save(:validate => false)
        trumpet = Instrument.new(:name => "Trumpet")
        trumpet.save(:validate => false)
        trombone = Instrument.new(:name => "Trombone")
        trombone.save(:validate => false)
        baritone = Instrument.new(:name => "Baritone Horn")
        baritone.save(:validate => false)
        tuba = Instrument.new(:name => "Tuba")
        tuba.save(:validate => false)
        guitar = Instrument.new(:name => "Guitar")
        guitar.save(:validate => false)
        bass = Instrument.new(:name => "Bass")
        bass.save(:validate => false)
        ukulele = Instrument.new(:name => "Ukulele")
        ukulele.save(:validate => false)
        sitar = Instrument.new(:name => "Sitar")
        sitar.save(:validate => false)
        tabla = Instrument.new(:name => "Tabla")
        tabla.save(:validate => false)
        violin = Instrument.new(:name => "Violin")
        violin.save(:validate => false)
        viola = Instrument.new(:name => "Viola")
        viola.save(:validate => false)
        cello = Instrument.new(:name => "Cello")
        cello.save(:validate => false)
        singer = Instrument.new(:name => "Voice")
        singer.save(:validate => false)
        electronic = Instrument.new(:name => "Electronic (Laptop)")
        electronic.save(:validate => false)
        drum = Instrument.new(:name => "Drums")
        drum.save(:validate => false)
        perc = Instrument.new(:name => "Percussion")
        perc.save(:validate => false)
        oboe = Instrument.new(:name => "Oboe")
        oboe.save(:validate => false)
  
        classical = Genre.new(:name => "Classical")
        classical.save(:validate => false)
        jazz = Genre.new(:name => "Jazz")
        jazz.save(:validate => false)
        rock = Genre.new(:name => "Rock")
        rock.save(:validate => false)
        pop = Genre.new(:name => "Pop")
        pop.save(:validate => false)
        country = Genre.new(:name => "Country")
        country.save(:validate => false)
        alt = Genre.new(:name => "Alternative Music")
        alt.save(:validate => false)
        blues = Genre.new(:name => "Blues")
        blues.save(:validate => false)
        electronica = Genre.new(:name => "Electronica")
        electronica.save(:validate => false)
        house = Genre.new(:name => "House")
        house.save(:validate => false)
        european = Genre.new(:name => "European Music")
        european.save(:validate => false)
        hiphop = Genre.new(:name => "Hip hop/Rap")
        hiphop.save(:validate => false)
        indiepop = Genre.new(:name => "Indie Pop")
        indiepop.save(:validate => false)
        asianpop = Genre.new(:name => "Asian Pop (K-Pop, J-Pop)")
        asianpop.save(:validate => false)
        latin = Genre.new(:name => "Latin")
        latin.save(:validate => false)
        opera = Genre.new(:name => "Opera")
        opera.save(:validate => false)
        rbsoul = Genre.new(:name => "R&B/Soul")
        rbsoul.save(:validate => false)
        reggae = Genre.new(:name => "Reggae")
        reggae.save(:validate => false)
        folk = Genre.new(:name => "Folk")
        folk.save(:validate => false)
        broadway = Genre.new(:name => "Broadway")
        broadway.save(:validate => false)

        organize = Activity.new(:name => "Organize/produce/help with an event")
        organize.save(:validate => false)
        design = Activity.new(:name => "Help design a poster")
        design.save(:validate => false)
        develop = Activity.new(:name => "Help develop a website")
        develop.save(:validate => false)
        house_concert = Activity.new(:name => "Host a house concert")
        house_concert.save(:validate => false)
        help_produce_marketing = Activity.new(:name => "Help produce marketing materials")
        help_produce_marketing.save(:validate => false)
        donate_funds = Activity.new(:name => "Donate funds")
        donate_funds.save(:validate => false)

        chamber_music = Interest.new(:name => "Read chamber music")
        chamber_music.save(:validate => false)
        form_chamber_group = Interest.new(:name => "Forming a chamber group")
        form_chamber_group.save(:validate => false)
        orchestra = Interest.new(:name => "Playing in an orchestra")
        orchestra.save(:validate => false)
        jazz_combo = Interest.new(:name => "Forming a jazz combo")
        jazz_combo.save(:validate => false)
        jamming = Interest.new(:name => "Jamming")
        jamming.save(:validate => false)
        singing = Interest.new(:name => "Singing")
        singing.save(:validate => false)
        sightreading = Interest.new(:name => "Sightreading with other musicians")
        sightreading.save(:validate => false)
        chorus = Interest.new(:name => "Singing in a chorus or a cappella group")
        chorus.save(:validate => false)
        concert = Interest.new(:name => "Performing in public concerts")
        concert.save(:validate => false)
        outreach = Interest.new(:name => "Playing for outreach/charity")
        outreach.save(:validate => false)
        background = Interest.new(:name => "Peforming background music for local events")
        background.save(:validate => false)
        benefit = Interest.new(:name => "Performing in benefit concerts")
        benefit.save(:validate => false)
        

    end
    
    def down
        InstrumentSkill.delete_all
        User.delete_all
        Genre.delete_all
        Instrument.delete_all
        Activity.delete_all
        Interest.delete_all
    end
end
