require "./french_cal/*"

module FrenchCal
  FIRST_DAY = ::Time.new(1792, 9, 22)

  TERMINASONS   = %w(-aire -ose -al -idor)
  MONTHS        = %w(Vendémiaire Brumaire Frimaire Nivôse Pluviôse Ventôse Germinal Floréal Prairial Messidor Thermidor Fructidor)
  DAYS          = %w(Primidi8 Duodi Tridi Quartidi Quintidi Sextidi Septidi Octidi Nonidi Décadi)
  DECADES_COUNT = 3
  DAYS_BY_MONTH = DECADES_COUNT * DAYS.size

  SEXTILE_EVERY = 4 # every 4 years
  SEXTILE_FIRST = 0 # 3 initialy, then 20

  SANCULOTTIDES_DAYS         = %w(vertu génie travail opinion récompenses)
  SANCULOTTIDES_SEXTILE_DAYS = SANCULOTTIDES_DAYS + %w(révolution)

  DAYS_BY_YEAR_BASE    = DAYS_BY_MONTH * MONTHS.size
  DAYS_BY_SEXTILE_YEAR = DAYS_BY_YEAR_BASE + SANCULOTTIDES_SEXTILE_DAYS.size
  DAYS_BY_CLASSIC_YEAR = DAYS_BY_YEAR_BASE + SANCULOTTIDES_DAYS.size

  HOUR    = 1.day / 10.0
  MINUTES = HOUR / 10.0
  SECONDS = MINUTES / 10.0

  def self.fnow
    (::Time.now - FIRST_DAY)
  end

  def self.is_sextile?(year : Int)
    (year - SEXTILE_FIRST) % SEXTILE_EVERY == 0
  end

  module Time
    private def fnow
      (self - FrenchCal::FIRST_DAY)
    end

    def is_sextile?
      FrenchCal.is_sextile?(fyear)
    end

    def days_this_year
      is_sextile? ? CLASSIC_YEAR_DAYS_COUNT : SEXTILE_YEAR_DAYS_COUNT
    end

    def fyear
      # TODO: fix the incremental number depending on original date
      days = fnow.total_days + 2
      quat = days / (DAYS_BY_CLASSIC_YEAR * (SEXTILE_EVERY - 1) + DAYS_BY_SEXTILE_YEAR)
      year = (quat * 4).floor.to_i64 + 1
      year
    end

    def fday_of_the_year
      days = fnow.total_days
      years = fyear - 1
      sextile_years = (years / 4).ceil
      sextile_days = sextile_years * DAYS_BY_SEXTILE_YEAR
      classic_years = (years - sextile_years)
      classic_days = classic_years * DAYS_BY_CLASSIC_YEAR
      years_days = sextile_days + classic_days
      (days - years_days).ceil.to_i64 + 1
    end

    def fday
      fday_of_the_year % DAYS_BY_MONTH
    end

    def fmonth
      (fday_of_the_year / DAYS_BY_MONTH).ceil.to_i64 + 1
    end
  end
end

struct Time
  include FrenchCal::Time
end
