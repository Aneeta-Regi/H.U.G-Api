desc 'make a call to signup genius'
task :add_sg_to_mc => :environment do
  # find the last user import record
  @lui = Lastuserimport.find_by_group_id(13612051)

  # call to signup retrieve list of users.
  response = RestClient::Request.execute(method: :get,
                                         url: 'https://api.signupgenius.com/v2/k/signups/report/all/12576821/?user_key=NWp6N0J2U1A3M2I3RjhzQXlhWlFjdz09',
                                         headers: {Accept: 'application/json'})

  # setup a new request to call mailchimp
  gibbon = Gibbon::Request.new(api_key: '532ce85c94cc16caca079c3339c44877-us13')
  # go get current member list emails only (mailchimp)
  mcresponse = gibbon.lists('72f372f582').members.retrieve(params: {count: '500', fields: 'members.email_addresses'})
  # put the response emails into a clean array so we can use .include?
  mc = []
  mcresponse.body['members'].each do |ema|
    mc << ema['email_address']
  end
  # check each new signup to see if its in the clean array from above
  JSON.parse(response)['data']['signup'].each do |u|
    # because singup genius has a blank entry for every slot in the list we check for empties
    # check if this record is an old one and has been entered in before.
    if u['email'].empty? || @lui.members.include?(u['email'])

    else
      unless mc.include? u['email']
        gibbon.lists('72f372f582').members.create(body: { email_address: u['email'],
                                                         status: 'subscribed',
                                                         merge_fields: {FNAME: u['firstname'], LNAME: u['lastname']},
                                                         interests: {d403ee5562: true} })
      end
      @lui.memberarray << u['email']
    end
  end
  @lui.save
  p @lui
  p 'I ran 1312051'
end


desc 'check for new users in mail chimp'
task :check_new_users => :environment do
  # setup a hash of school ids.
  school_map = {'6623e2e947' => 8, '31f058722b' => 7, '1e37ea5e98' => 30, 'a2d7729624' => 9, 'a6de26f7bb' => 27, '8529f17927' => 31,
                '72fc215e16' => 36,'1e72c8bcf7' => 35,'2fedac248e' => 34,'9e50686bda' => 33 ,'a8ee22130a' => 37,}
  # dev school_map for testing only
  # school_map = {'6623e2e947' => 8, '31f058722b' => 32, 'a2d7729624' => 9}
  gibbon = Gibbon::Request.new(api_key: '532ce85c94cc16caca079c3339c44877-us13')
  # go get current member list (mailchimp)
  newusers = gibbon.lists('72f372f582').members.retrieve(params: { count: '500' })
  newusers.body['members'].each do |user|
    school_ids = []
    # check if each user is already in the DB.
    if User.find_by_email(user['email_address']).nil?
      # check which school they want to volunteer at
      user['interests'].each do |key, value|
        if value && school_map[key]
          school_ids << school_map[key]
        end
      end
      # create the new user and save if the school list is not empty.
      unless school_ids.empty?
        # gotta have a password or devise won't let us save the user.
        pass = SecureRandom.random_number(36**12).to_s(36).rjust(12, '0')
        user['merge_fields']['FNAME'].empty? ? first_name = 'NoName' : first_name = user['merge_fields']['FNAME']
        user['merge_fields']['LNAME'].empty? ? last_name = 'Mailchimp' : last_name = user['merge_fields']['LNAME']
        values = { first_name: first_name, last_name: last_name,
                   email: user['email_address'], school_id: school_ids, password: pass }
        @new_user = User.create(values)
        @new_user.school_id.each do |s|
          school = School.find(s)
          @new_user.schools << school
        end
        @new_user.save
      end
    end
  end
  p 'all done with user imports'
end

desc 'update all sessions'
task :update_all_sessions => :environment do
  # get all sessions to update
  sessions = Session.where(second_attempt: true)
  sessions.each do |s|
    #set the student
    student = Student.find(s.student_id)
    lesson = Lesson.find(s.lesson_id)
    school = School.find(student.school_id)

    # set the school year
    p s.date
    p s.date.to_s
    p s.date.year
    p s.date.month
    # date_obj = s.date.to_s.partition(' ').first
    # year = date_obj.partition('-').first.to_i
    # step1 = date_obj.partition('-').last
    # month = step1.partition('-').first.to_i
    if s.date.month > 6
      syB = s.date.year + 1
      syA = s.date.year
    else
      syB = s.date.year
      syA = s.date.year - 1
    end
    school_year = syA.to_s + '/' + syB.to_s

    # set the session values
    s.student_name = student.first_name + ' ' + student.s_last_name
    s.grade_level = lesson.grade_level
    s.school_id = school.id
    s.school_name = school.school_name
    s.school_year = school_year
    s.save
  end
end

