#menu
#nome cognome data di nascita manda per parametro ad un csv
#lettura csv in tabella
#uscita

require "csv"
require 'terminal-table'

punto_menu="0"
while punto_menu!="4"
  puts "Scegliere il punto del menu: \n1)Scrittura dei dati\n2)Lettura dei dati\n3)Media dei voti\n4)Uscita\n"
  punto_menu=gets.chomp

  case punto_menu
  when "1"
    puts "Inserire la materia"
    mat = gets.chomp

    puts "Inserire il voto"
    voto = gets.to_f

    puts "Inserire se scritto o orale"
    tip = gets.chomp
    if tip=="scritto"
      CSV.open("EsercizioCSV.csv", "a+") do |csv|
        csv << [mat, voto]
      end
    else
      CSV.open("EsercizioCSV2.csv", "a+") do |csv|
        csv << [mat, voto]
      end
    end

  when "2"

    rows=[]
    head=[]
    i=0
    CSV.foreach("EsercizioCSV.csv") do |row|
      if i==0
        head=row
        i=1
      else
        rows << row
      end
    end
    table1 = Terminal::Table.new :title => 'Scritto', :headings => head, :rows => rows

    rows=[]
    head=[]
    i=0
    CSV.foreach("EsercizioCSV2.csv") do |row|
      if i==0
        head=row
        i=1
      else
        rows << row
      end
    end
    table2 = Terminal::Table.new :title => 'Orale', :headings => head, :rows => rows

    puts table1
    puts table2

  when "3"
    materie=[]
    t=0
    CSV.foreach("EsercizioCSV.csv") do |row|
      if t==0
        t=1
      else
        materie << row[0]
      end
    end
    n=0
    while materie[n]!=nil
      i=0
      while materie[i]!=nil
        if materie[n]==materie[i] && n!=i
           materie.slice!(i)
        end
        i+=1
      end
      n+=1
    end

    materie_ms=[]
    voti_ms=[]
    t=0
    CSV.foreach("EsercizioCSV.csv") do |row|
      if t==0
        t=1
      else
        materie_ms << row[0]
        voti_ms << row[1].to_f
      end
    end

    n=0
    i=0
    while materie[n]!=nil
      media=0
      m=0
      i=0
      while materie_ms[i]!=nil
        if materie[n]==materie_ms[i]
          media+=voti_ms[i]
          m+=1
        end
        i+=1
      end
      media=media/m
      puts "La media degli scritti di #{materie[n]} è #{media}"
      n+=1
    end

    materie=[]
    t=0
    CSV.foreach("EsercizioCSV2.csv") do |row|
      if t==0
        t=1
      else
        materie << row[0]
      end
    end
    n=0
    while materie[n]!=nil
      i=0
      while materie[i]!=nil
        if materie[n]==materie[i] && n!=i
           materie.slice!(i)
        end
        i+=1
      end
      n+=1
    end

    materie_mo=[]
    voti_mo=[]
    t=0
    CSV.foreach("EsercizioCSV2.csv") do |row|
      if t==0
        t=1
      else
        materie_mo << row[0]
        voti_mo << row[1].to_f
      end
    end

    n=0
    i=0
    while materie[n]!=nil
      media=0
      m=0
      i=0
      while materie_mo[i]!=nil
        if materie[n]==materie_mo[i]
          media+=voti_mo[i]
          m+=1
        end
        i+=1
      end
      media=media/m
      puts "La media degli orali di #{materie[n]} è #{media}"
      n+=1
    end

  when "4"
    puts "Uscita"

  else
    puts "Errore"

  end

end
