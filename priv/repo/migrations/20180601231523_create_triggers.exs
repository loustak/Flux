defmodule Flux.Repo.Migrations.Triggers do
  use Ecto.Migration

  def change do

    # Trigger 1: Create a default community for every new users
    execute "CREATE OR REPLACE FUNCTION create_default_community() RETURNS trigger AS
    $$
    DECLARE
      save_community_id bigint;
    BEGIN
      INSERT INTO communities(user_id, name, inserted_at, updated_at) values(NEW.id, NEW.username, now(), now()) RETURNING id into save_community_id;
      RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    "

    execute "DROP TRIGGER IF EXISTS create_default_community on users;"
    execute "CREATE TRIGGER create_default_community AFTER INSERT ON users
    FOR EACH ROW
    EXECUTE PROCEDURE create_default_community();"

    # Trigger 2: The user who create a community join it and create a default discussion
    execute "CREATE OR REPLACE FUNCTION join_created_community() RETURNS trigger AS
    $$
    BEGIN
      INSERT INTO discussions(community_id, name, inserted_at, updated_at) values(NEW.id, 'Main', now(), now());
      INSERT INTO user_communities(user_id, community_id, inserted_at, updated_at) values(NEW.user_id, NEW.id, now(), now());
      RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;"

    execute "DROP TRIGGER IF EXISTS trigger_join_created_community on communities;"
    execute "CREATE TRIGGER trigger_join_created_community AFTER INSERT ON communities
    FOR EACH ROW
    EXECUTE PROCEDURE join_created_community();"
  end
end