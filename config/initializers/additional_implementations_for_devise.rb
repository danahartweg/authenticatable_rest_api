# Inserting additional devise dependencies

ActionController::API.send :include, ActionController::Flash
ActionController::API.send :include, ActionController::MimeResponds
