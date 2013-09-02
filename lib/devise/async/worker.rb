module Devise
  module Async
    class Worker
      # Used is the internal interface for devise-async to enqueue notifications
      # to the desired backend.
      def self.enqueue(method, resource_class, resource_id)
        backend_class.enqueue(method, resource_class, resource_id, mailer_class_attributes)
      end

      private

      def self.mailer_class_attributes
        if mailer_class.respond_to?(:attributess)
          mailer_class.attributess.clone
        else
          {}
        end
      end

      def self.mailer_class
        Devise::Async.mailer.constantize
      end

      def self.backend_class
        Backend.for(Devise::Async.backend)
      end
    end
  end
end
