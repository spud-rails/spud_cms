class SnippetSweeper < ActionController::Caching::Sweeper
  observe :spud_snippet

  def before_save(record)
    if record.is_a?(SpudSnippet)
      @old_name = record.name_was
    else
      @old_name = nil
    end
  end

  def after_save(record)
    reset_cms_pages(record)
  end

  def after_destroy(record)
    reset_cms_pages(record)
  end

private
  def reset_cms_pages(record)

    values = [record.name]
    values << @old_name if !@old_name.blank?
    SpudPageLiquidTag.where(:tag_name => "snippet",:value => values).includes(:attachment).each do |tag|
      partial = tag.attachment
      partial.postprocess_content
      partial.save
      page = partial.try(:spud_page)
      if page.blank? == false
        page.updated_at = Time.now.utc
        page.save
      end


    end
  end



end
