class Import < ApplicationRecord
  def self.import(file)
    good_users = []
    bad_users = []
    users = []
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = User.new
      user.first_name = row["first_name"].capitalize
      user.last_name = row["last_name"].capitalize
      user.email = row["email"]
      user.error_message = ''
      error = false
      if User.where(email: user.email).count > 0
        error = true
        user.add_error('Email déjà éxistante')
      end
      if User.where(first_name: user.first_name).where(last_name: user.last_name).count > 0
        error = true
        user.add_error('Nom et prénom déjà existants')
      end
      if user.first_name.size < 3
        error = true
        user.add_error('Prénom inférieur à 3 caractères')
      end
      if user.last_name.size < 3
        error = true
        user.add_error('Nom inférieur à 3 caractères')
      end
      if !EmailValidator.valid?(user.email)
        #if user.email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
        error = true
        user.add_error('Email non conforme')
      end
      if !(/^[[:alpha:]\s'"\-_&@!?()\[\]-]*$/u =~ user.first_name)
        error = true
        user.add_error('Prénom non valide')
      end
      if !(/^[[:alpha:]\s'"\-_&@!?()\[\]-]*$/u =~ user.last_name)
        error = true
        user.add_error('Nom non valide')
      end
      if error
        bad_users.push(user)
      else
        good_users.push(user)
      end
      user.save
    end
    users.push(good_users).push(bad_users)
  end
end