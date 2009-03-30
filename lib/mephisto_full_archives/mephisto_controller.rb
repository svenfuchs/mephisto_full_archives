module MephistoFullArchives
  module MephistoController
    def self.included(base)
      base.send :alias_method_chain, :dispatch_archives, :full_archives
    end

    def dispatch_archives_with_full_archives
      if params['path'].length == 1 # i.e. no year and month given
        render_liquid_template_for(:archive, 'section' => @section, 'articles' => articles_by_month)
      else
        dispatch_archives_without_full_archives
      end
    end

    # TODO should really be on the model
    def articles_by_month
      @articles = @section.articles.find(:all, :include => :user,
        :conditions => ['contents.published_at IS NOT NULL'], :order => 'contents.published_at DESC')
    end
  end
end