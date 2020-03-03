require ('pg')

class Property

  attr_accessor :address, :year_built, :buy_let_status, :square_footage
  attr_reader   :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @year_built = options['year_built']
    @buy_let_status = options['buy_let_status']
    @square_footage = options['square_footage']
  end

  def save
    db = PG.connect({dbname:'property_agency', host: 'localhost'})
    sql = "INSERT INTO properties
          (address,
            year_built,
            buy_let_status,
            square_footage)
            VALUES
            ($1,$2,$3,$4)
            RETURNING *"
      values = [@address, @year_built, @buy_let_status, @square_footage]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]['id'].to_i
      db.close()
  end

  def delete
    db = PG.connect({dbname:'property_agency', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values =[@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update
    db = PG.connect({dbname: 'property_agency', host: 'localhost'})
    sql = "UPDATE properties
          SET ( address,
                year_built,
                buy_let_status,
                square_footage)
          = ($1, $2, $3, $4)
          WHERE id = $5"
          values = [@address, @year_built, @buy_let_status, @square_footage, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close
  end

  # def find
  #   db = PG.connect({dbname: 'property_agency', host: 'localhost'})
  #   sql = "SELECT FROM properties
  #             ( address,
  #               year_built,
  #               buy_let_status,
  #               square_footage)
  #         = ($1, $2, $3, $4)
  #         WHERE id = $5"
  #         values = [@address, @year_built, @buy_let_status, @square_footage, @id]
  #     db.prepare("find", sql)
  #     db.exec_prepared("find", values)
  #     db.close
  # end

  def Property.find
    db = PG.connect({dbname:'property_agency', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = 13"
    db.prepare("all", sql)
    property_found = db.exec_prepared("all")
    db.close()
    return property_found.map {|each_property| Property.new(each_property) }
  end

  def Property.find_by_address
    db = PG.connect({dbname:'property_agency', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = '14 High Street'"
    db.prepare("all", sql)
    property_found = db.exec_prepared("all")
    db.close()
    property_by_address = property_found.map {|each_property| Property.new(each_property) }
    if property_by_address.size == 0
      return nil
    else
      return property_by_address.first
    end
  end


end
