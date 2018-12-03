require 'csv'

class Array

  def imp_mat(fileCSV)
    materie=[]
    t=0
    CSV.foreach(fileCSV) do |row|
      if t==0
        t=1
      else
        materie << row[0]
      end
    end
    yield materie
  end

  def import_materie(fileCSV)
    materie=[]
    t=0
    CSV.foreach(fileCSV) do |row|
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
    yield materie
  end

  def import_voti(fileCSV)
    voti=[]
    t=0
    CSV.foreach(fileCSV) do |row|
      if t==0
        t=1
      else
        voti << row[1].to_f
      end
    end
    yield voti
  end

  def media(materie_nr,materie,voti)
    n=0
    i=0
    medie=[]
    while materie_nr[n]!=nil
      media=0
      m=0
      i=0
      while materie[i]!=nil
        if materie_nr[n]==materie[i]
          media+=voti[i]
          m+=1
        end
        i+=1
      end
      media=media/m
      puts "La media degli orali di #{materie[n]} è #{media}"
      n+=1
    end
    yield medie
  end

end



materie1=[]
materie1.import_materie("EsercizioCSV.csv") do |materie1|
  #puts materie1
end

materie_scritto=[]
materie_scritto.imp_mat("EsercizioCSV.csv") do |materie_scritto|
  #puts materie_scritto
end

voti_scritto=[]
voti_scritto.import_voti("EsercizioCSV.csv") do |voti_scritto|
  #puts voti_scritto
end

materie2=[]
materie2.import_materie("EsercizioCSV2.csv") do |materie2|
  #puts materie2
end

materie_orali=[]
materie_orali.imp_mat("EsercizioCSV2.csv") do |materie_orali|
  #puts materie_orali
end

voti_orali=[]
voti_orali.import_voti("EsercizioCSV2.csv") do |voti_orali|
  #puts voti_orali
end

media_scritto=[]
media_scritto.media(materie1,materie_scritto,voti_scritto) do |media_scritto|
  puts media_scritto
end

media_orali=[]
media_orali.media(materie2,materie_orali,voti_orali) do |media_orali|
  puts media_orali
end
