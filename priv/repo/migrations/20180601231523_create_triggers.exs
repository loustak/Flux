defmodule Flux.Repo.Migrations.Triggers do
  use Ecto.Migration

  def change do

    execute "CREATE OR REPLACE FUNCTION create_default_community() RETURNS trigger AS
    $$
    DECLARE
      save_community_id bigint;
    BEGIN
      INSERT INTO communities(user_id, name, inserted_at, updated_at) values(NEW.id, NEW.username, now(), now()) RETURNING id into save_community_id;
      INSERT INTO discussions(community_id, name, inserted_at, updated_at) values(save_community_id, 'Default', now(), now());
      INSERT INTO user_communities(user_id, community_id, inserted_at, updated_at) values(NEW.id, save_community_id, now(), now());
      RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    "

    execute "DROP TRIGGER IF EXISTS create_default_community on users;"

    execute "CREATE TRIGGER create_default_community AFTER INSERT ON users
    FOR EACH ROW
    EXECUTE PROCEDURE create_default_community();"
  end
end