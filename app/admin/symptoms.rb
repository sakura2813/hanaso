# app/admin/symptoms.rb
ActiveAdmin.register Symptom do
  permit_params :title, :summary, :home_care, :checkpoints, :visit_immediate, :visit_hours, :image

  index do
    selectable_column
    id_column
    column :title
    column :image do |s|
      image_tag url_for(s.image.variant(resize_to_fill: [48, 48])), class: 'rounded' if s.image.attached?
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :summary
      row :home_care
      row :checkpoints
      row :visit_immediate
      row :visit_hours
      row :image do |s|
        image_tag url_for(s.image.variant(resize_to_fit: [800, 600])) if s.image.attached?
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :summary
      f.input :home_care
      f.input :checkpoints
      f.input :visit_immediate
      f.input :visit_hours
      f.input :image, as: :file,
                      hint: (image_tag url_for(f.object.image), style: 'height:80px' if f.object.image.attached?)
    end
    f.actions
  end

  filter :title
  filter :created_at
end
