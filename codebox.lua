function CodeBlock(block)
  if FORMAT == 'latex' or FORMAT == 'beamer' then
    local lang = ''
    if #block.classes > 0 then
      lang = block.classes[1]
    end
    local label = block.identifier
    local attrs = {}
    local comments = ''
    local caption = ''
    for k, v in pairs(block.attributes) do
      if k == 'comments' then
        comments = v
      end
      if k == 'caption' then
        caption = v
      else
        table.insert(attrs, string.format('%s={%s}', k, v))
      end
    end
    if lang ~= '' then
      table.insert(attrs, string.format('lang={%s}', lang))
    end
    if label ~= nil or lable ~= '' then
      table.insert(attrs, string.format('label={%s}', label))
    end
    local options = table.concat(attrs, ',')
    local tag = ''
    if lable ~= '' then
      tag = 'codeview'
    else
      tag = 'codebox'
    end
    if comments ~= '' then
      tag = tag .. '*'
    end
    local raw = string.format("\\removespace\n\\begin{%s}[%s]{%s}\n%s\n\\end{%s}\n\\restorespace", tag, options, caption, block.text, tag)
    return pandoc.RawBlock("latex", raw)
  end
end