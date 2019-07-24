module Delta
  def self.to_markdown(ops)
    ops.each_with_index.reduce('') do |memo, (op, idx)|
      insert = op['insert']
      next_op = ops[idx + 1]

      if insert['image']
        insert = "![](#{insert['image']})"
      end

      if op.dig('attributes', 'link')
        insert = "[#{insert}](#{op['attributes']['link']})"
      end

      if op.dig('attributes', 'bold')
        insert = "**#{insert}**"
      end

      if op.dig('attributes', 'italic')
        insert = "*#{insert}*"
      end

      if next_op&.dig('attributes', 'list')
        insert = "- #{insert}"
      end

      memo += insert
    end
  end
end
