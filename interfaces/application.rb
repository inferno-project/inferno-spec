require 'lib/interface'

module Inferno
  module Interfaces

    class Application < Inferno::Interface

      ##
      # Configure application
      #
      # Example:
      #
      #     configure do
      #       timezone 'UTC'
      #     end
      #
      #     configure :development do
      #       preload false
      #     end
      #
      # Params:
      # - environment {Symbol} Environment for the following configuration (optional)
      #
      # Yields: block with configuration
      #
      def_class_method :configure, [:opt, :environment], [:block, :block]

      ##
      # Configure path for the group
      #
      # Example:
      #
      #     path_for :controllers, 'app/controllers'
      #     path_for :routes,      'config/routes.rb'
      #
      # Params:
      # - group         {Symbol} Group name
      # - relative_path {String} Path relative to the application root
      #
      def_class_method :path_for, [:req, :group], [:req, :relative_path]

      ##
      # Get configuration
      #
      def_instance_method :configuration

      ##
      # Get path resolver
      #
      def_instance_method :paths

      ##
      # Rack interface
      #
      # Params:
      # - env {Hash} Hash of rack environment variables
      #
      # Returns: Rack response {Array}
      #
      def_instance_method :call, [:req, :env], return: Array

    end

  end
end