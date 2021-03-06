require 'lib/conio'

class Contact
  extend ConIO
  include ConIO
  attr_accessor :phonebook

  def initialize(pb)
    @phonebook = pb
  end

  def self.add_new(phonebook)
    name = prompt('Enter new name: ')
    number = prompt('Enter new number: ')
    phonebook.add_entry(name, number)
  end

  def update
    # Reads entire phonebook into memory. Ugh.
    index = find_by_name(true)
    number = prompt('Enter new number: ')
    @phonebook.update(index, number)
  end

  def find_by_name(get_index=false)
    find :name, prompt('Enter name to find: ').downcase()
    if get_index
      return prompt('Enter index number to change: ')
    end
  end

  # Not a requirement, but we can leverage this method to ask for which record
  # to update, just like we did with find_by_name
  def find_by_number
    find :number, prompt('Enter number to find: ').downcase()
  end

  private
  def print_entry(line)
    puts line.values_at(:index, :number, :name).join( "\t" )
  end

  def find(key, item)
    @phonebook.read do |line|
      print_entry line if /#{item}/ === line[key].downcase
    end
  end
end
