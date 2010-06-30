VcardDictionary.create(:klass => 'category', 'name' => 'travel agent')
VcardDictionary.create(:klass => 'category', 'name' => 'internet')
VcardDictionary.create(:klass => 'category', 'name' => 'ietf')
VcardDictionary.create(:klass => 'category', 'name' => 'industry')
VcardDictionary.create(:klass => 'category', 'name' => 'information technology')

VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-aim', 'description' => 'aim:#{value}')
VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-icq', 'description' => 'icq:#{value}/') # http://www.icq.com/people/#{value}
VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-xmpp', 'description' => 'xmpp:#{value}')
VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-msn', 'description' => 'msn:#{value}')
VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-yahoo', 'description' => 'yahoo:#{value}')
VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-twitter', 'description' => 'http://twitter.com/#{value}')
VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-skype', 'description' => 'skype:#{value}')
VcardDictionary.create(:klass => 'extention_type', 'name' => 'x-livejournal', 'description' => 'http://#{value}.livejournal.com/')
