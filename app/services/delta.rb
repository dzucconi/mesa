# frozen_string_literal: true
module Delta
  def self.to_markdown(ops)
    ops.each_with_index.reduce('') do |memo, (op, idx)|
      insert = op['insert']
      next_op = ops[idx + 1]

      insert = "![](#{insert['image']})" if insert['image']

      if op.dig('attributes', 'link')
        insert = "[#{insert}](#{op['attributes']['link']})"
      end

      insert = "**#{insert}**" if op.dig('attributes', 'bold')

      insert = "*#{insert}*" if op.dig('attributes', 'italic')

      insert = "- #{insert}" if next_op&.dig('attributes', 'list')

      memo + insert
    end
  end
end
