class LoadPresetData < ActiveRecord::Migration
    def up
        down

        alto_sax = Instrument.new(:name => "Alto Saxophone")
        alto_sax.save(:validate => false)
        tenor_sax = Instrument.new(:name => "Tenor Saxophone")
        tenor_sax.save(:validate => false)
        f_horn = Instrument.new(:name => "French Horn")
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
        singer = Instrument.new(:name => "Singer")
        singer.save(:validate => false)
        sitar = Instrument.new(:name => "Indian - Sitar")
        sitar.save(:validate => false)
        tabla = Instrument.new(:name => "Indian - Tabla")
        tabla.save(:validate => false)
        violin = Instrument.new(:name => "Strings - Violin")
        violin.save(:validate => false)
        viola = Instrument.new(:name => "Strings - Viola")
        viola.save(:validate => false)
        cello = Instrument.new(:name => "Strings - Cello")
        cello.save(:validate => false)
        other = Instrument.new(:name => "Other")
        other.save(:validate => false)
  
        classical = Genre.new(:name => "Classical")
        classical.save(:validate => false)
        jazz = Genre.new(:name => "Jazz")
        jazz.save(:validate => false)
        rock = Genre.new(:name => "Rock")
        rock.save(:validate => false)
        pop = Genre.new(:name => "Pop")
        pop.save(:validate => false)


        organize = Activity.new(:name => "Organize/produce an event")
        organize.save(:validate => false)
        design = Activity.new(:name => "Help design a poster")
        design.save(:validate => false)
        develop = Activity.new(:name => "Help develop a website")
        develop.save(:validate => false)
        house_concert = Activity.new(:name => "Host a house concert")
        house_concert.save(:validate => false)
        help_with_concert = Activity.new(:name => "Help with Fall and Winter Concert on Campus")
        help_with_concert.save(:validate => false)
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
        

        # ds = User.new(:first_name => "Diveesh", :last_name => "Singh", :login_name => "diveesh",  :affiliation => "AFFIL 2", :email_address => "diveesh@gmail.com")
        # ds.instruments << alto_sax
        # ds.instruments << piano
        # ds.genres << jazz
        # ds.activities << organize
        # ds.interests << chamber_music
        # ds.password = "test"
        # ds.save(:validate => false)
        # jb = User.new(:first_name => "Justin", :last_name => "Bieber", :login_name => "bieber", :email_address => "bieber@gmail.com")
        # jb.instruments << clar
        # jb.genres << pop
        # jb.interests << orchestra
        # jb.password = "test"
        # jb.save(:validate => false)
        # ph = User.new(:first_name => "Paris",  :last_name => "Hilton", :login_name => "hilton",  :email_address => "hilton@gmail.com")
        # ph.password = "test"
        # ph.save(:validate => false)
        # mc = User.new(:first_name => "Miley",  :last_name => "Cyrus", :login_name => "cyrus", :email_address => "cyrus@gmail.com")
        # mc.instruments << clar
        # mc.instruments << piano
        # mc.password = "test"
        # mc.save(:validate => false)
        # bo = User.new(:first_name => "Barack", :last_name => "Obama", :login_name =>  "obama", :email_address => "obama@gmail.com")
        # bo.genres << rock
        # bo.password = "test"
        # bo.save(:validate => false)

    end
    
    def down
        Genre.delete_all
        Instrument.delete_all
        Activity.delete_all
    end
end
