module SeedDump
  def dump()
    out = File.open('db/seeds.rb','w')
    out.write ("ActiveRecord::Base.transaction do\n")
    models= ActiveRecord::Base.descendants
    models.each do |model|
      model.all.each do |obj|
        s = StringIO.new
        obj.attributes.each do |key,value|
          if value.nil?
            value_s='nil'
          elsif [Hash,Array].include?(value.class)
            value_s="#{value.inspect}"
          else
            value_s="'#{value.to_s}'"
          end
          s.write "'#{key.to_s}'=> #{value_s} ,"
        end
        out.write "#{model.to_s}.create!(#{s.string})\n"
      end
    end
    puts "done"
    out.write("end\n")
  end
end

