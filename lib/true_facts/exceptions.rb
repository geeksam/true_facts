class TrueFacts
  class WellActuallyError < ArgumentError
    def initialize(fact_name, old_value, new_value)
      super <<EOF
Can't change [[ #{fact_name} ]]
from #{old_value.inspect}
  to #{new_value.inspect}
EOF
    end
  end

  class CircularLogicError < ArgumentError
  end
end
