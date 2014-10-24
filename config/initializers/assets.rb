Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.precompile += [
  'home.js',
  'home.css',
  'registrations.js',
  'registrations.css',
  'users.js',
  'announcements.js',
  'announcements.css',
  'restaurants.js',
  'restaurants.css',
  'subscriptions.js',
  'subscriptions.css',
  'messages.css',
  'sessions.css',
  'jquery.cycle.all.js'
]
