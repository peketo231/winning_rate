module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'WeRate'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def default_meta_tags
    {
      title: 'WeRate',
      description: 'ウイニングイレブンのRate変動を視覚的に表現するサービス',
      canonical: 'https://www.werate.jp',
      icon: [
        { href: asset_pack_url('media/images/favicon.ico') },
        { href: asset_pack_url('media/images/icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        title: 'WeRate',
        description: 'ウイニングイレブンのRate変動を視覚的に表現するサービス',
        type: 'website',
        url: 'https://www.werate.jp',
        image: asset_pack_url('media/images/ogp.png')
      },
      twitter: [
        card: 'summary_large_image'
      ]
    }
  end
end
