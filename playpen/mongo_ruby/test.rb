#!/usr/bin/ruby
require 'rubygems'
require 'mongo'

include Mongo

@client = MongoClient.new('localhost', 27017)
@db     = @client['results']
@coll   = @db['marketing_report_data']

space = "\n"*2
space

print "Print one object" << space
one = @coll.find_one
print one.to_s << space

print "Total number of objects in DB: " << @coll.count.to_s << space

print "Find objects by date range:"
date_range = @coll.find({"date" => {"$gt" => Time.utc(2013, 05, 12), "$lt" => Time.utc(2013, 05, 14)}}, :fields => ["date"]).to_a
print date_range.to_s << space

print "Find objects by date range and status:"
date_range = @coll.find({"date" => {"$gt" => Time.utc(2013, 05, 12), "$lt" => Time.utc(2013, 05, 14)}, "status" => "partial"}, :fields => ["date", "status"]).to_a
print date_range.to_s << space

print "Find objects by id: "
by_id = @coll.find({"_id" => BSON::ObjectId('5165c848421aa99a4e00000a')}, :fields => ["_id"]).to_a
print by_id.to_s << space

print "Find objects w/ invalid status: "  
status = @coll.find({"entitlement_status.status" => "valid"}, :fields => ["entitlement_status.status"]).to_a
print status.to_s << space

print "Find and Modify"
modify = @coll.find_and_modify({
	query: {"entitlement_status.status" => "valid"},
	update: {"id" => "asdf"} 
	})

print modify.to_s


