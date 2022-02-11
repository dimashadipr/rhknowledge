class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references  :user, default: nil
      t.string      :front_title
      t.string      :back_title
      t.string      :title
      t.string      :name
      t.string      :email
      t.string      :phone
      t.string      :institution
      t.string      :institution_phone
      t.string      :participant
      t.string      :topic
      t.string      :abstract
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
